import Ember from 'ember';

export default Ember.Controller.extend({
  ajax: Ember.inject.service(),
  routing: Ember.inject.service('-routing'),

  sentMessage: null,

  actions: {
    forgotPassword() {
      let { identification } = this.getProperties('identification');

      return this.get('ajax').request('/users/password', {
        method: 'POST',
        data: {
          email: identification,
          // Required by devise_token_auth
          // TODO improve location url
          redirect_url: window.location.href.replace('session/password_forgotten', 'echo.json')
        }
      })
      .then((response) => {
        this.set('errorMessage', null);
        this.set('sentMessage', response.message);
      })
      .catch((error) => {
        this.set('errorMessage', error.errors[0].title);
      });
    },
    clear () {
      this.set('sentMessage', null);
      this.set('identification', null);
    }
  }
});
