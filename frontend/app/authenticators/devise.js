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
   */
  authenticate(identification, password) {
    return new Promise((resolve, reject) => {
      const useResponse = this.get('rejectWithResponse');
      const { identificationAttributeName, tokenAttributeName } = this.getProperties('resourceName', 'identificationAttributeName', 'tokenAttributeName');
      const data = {
        email: identification,
        password: password
      };

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
});
