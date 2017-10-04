// app/authorizers/devise.js
import Ember from 'ember';

import DeviseAuthorizer from 'ember-simple-auth/authorizers/devise';

const { isEmpty } = Ember;

export default DeviseAuthorizer.extend({
  /* 
   * Overwrite method to include client data 
   *
   * devise-token-auth requires the client_id info. We need to add it to
   * the ember-simple-auth token header
   */
  authorize(data, block) {
    const { tokenAttributeName, identificationAttributeName } = this.getProperties('tokenAttributeName', 'identificationAttributeName');
    const userToken = data[tokenAttributeName];
    const userIdentification = data[identificationAttributeName];
    const userClient = data.client;

    if (!isEmpty(userToken) && !isEmpty(userIdentification)) {
      const authData = `${tokenAttributeName}="${userToken}", ${identificationAttributeName}="${userIdentification}", client="${userClient}"`;
      block('Authorization', `Token ${authData}`);
    }
  }
});
