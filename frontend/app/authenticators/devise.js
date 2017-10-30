import Ember from 'ember';
import DeviseAuthenticator from 'ember-simple-auth/authenticators/devise';

const { RSVP: { Promise }, run } = Ember;

export default DeviseAuthenticator.extend({
  resourceName: 'data',

  /*
   * Overwrite authenticate method
   *
   * devise-token-auth sends the credentials (token, client_id, uid) as
   * headers, while ember-simple-auth expects them inside the json data
   *
   * We are also adding a third parameter, dataFromPasswordRecovery.
   * It is used after exchanging the recover password token
   * devise-token-auth logs in the user and returns all the data
   * (token, client_id, uid), so no password is required
   */
  authenticate(identification, password, dataFromPasswordRecovery) {
    return new Promise((resolve, reject) => {
      const useResponse = this.get('rejectWithResponse');
      const { identificationAttributeName, tokenAttributeName } = this.getProperties('resourceName', 'identificationAttributeName', 'tokenAttributeName');
      const data = {
        email: identification,
        password: password
      };

      // Authenticates from password recovery token exchange
      if (dataFromPasswordRecovery) {
        let data = this.setDataFromPasswordRecovery(dataFromPasswordRecovery);

        run(null, resolve, data);

        return;
      }

      this.makeRequest(data).then((response) => {
        if (response.ok) {
          response.json().then((json) => {
            const resourceName = this.get('resourceName');

            // devise_token_auth provides with the token in the headers
            // Copy access-token and client id from headers to json
            json[resourceName][tokenAttributeName] = response.headers.get('access-token');
            json[resourceName].client = response.headers.get('client');

            if (this._validate(json)) {
              const _json = json[resourceName] ? json[resourceName] : json;
              run(null, resolve, _json);
            } else {
              run(null, reject, `Check that server response includes ${tokenAttributeName} and ${identificationAttributeName}`);
            }
          });
        } else {
          if (useResponse) {
            run(null, reject, response);
          } else {
            response.json().then((json) => run(null, reject, json));
          }
        }
      }).catch((error) => run(null, reject, error));
    });
  },

  /*
   * Sets the appropriate parameters
   * from the data returned by password recovery token exchange
   */
  setDataFromPasswordRecovery(data) {
    return {
      client: data.client_id,
      email: data.uid,
      provider: 'email',
      token: data.token,
      type: 'user',
      uid: data.uid
    };
  }
});
