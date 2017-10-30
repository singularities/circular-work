import Ember from 'ember';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),
  session: Ember.inject.service(),
  home: Ember.inject.controller(),

  actions: {
    setPassword() {
      let { password } = this.getProperties('password');
      let request;

      this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;

        request =  this.get('ajax').request('/users/password', {
          method: 'PUT',
          headers: headers,
          data: {
            password: password,
            password_confirmation: password
          }
        })
        .then((response) => {
          this.set('errorMessage', null);

          // FIXME notification component
          this.set('home.success', response.message);
          this.transitionToRoute('home');
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
