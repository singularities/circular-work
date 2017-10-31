import Ember from 'ember';

export default Ember.Component.extend({
  ajax: Ember.inject.service(),
  session: Ember.inject.service(),

  errorMessage: null,
  sentEmail: null,

  actions: {
    sendInvitation() {
      let { email } = this.getProperties('email');
      let request;

      this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;

        request =  this.get('ajax').request('/invitations', {
          method: 'POST',
          headers: headers,
          data: {
            email: email
          }
        })
        .then(() => {
          this.set('errorMessage', null);

          this.set('sentEmail', email);
          this.set('email', null);
        })
        .catch((error) => {
          console.dir(error);
          this.set('errorMessage', error.errors[0].title);
        });
      });

      return request;
    }
  }
});
