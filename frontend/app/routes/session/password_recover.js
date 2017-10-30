import Ember from 'ember';

export default Ember.Route.extend({
  ajax: Ember.inject.service(),
  session: Ember.inject.service(),

  // The token has already been sent and it should have already logged in
  tokenExchanged: false,

  beforeModel(transition) {
    if (this.get('tokenExchanged')) {
      return;
    }

    return this.get('ajax').request('/users/password/edit', {
      method: 'GET',
      data: {
        reset_password_token: transition.queryParams.token,
        redirect_url: transition.queryParams.redirect_url
      }
    })
    .then((response) => {
      this.set('tokenExchanged', true);
      this.set('session.attemptedTransition', transition);
      this.get('session').authenticate('authenticator:devise', null, null, response);
    })
    .catch((error) => {
      let controller = this.controllerFor('session.password_forgotten');
      controller.set('errorMessage', error.message);
      this.transitionTo('session.password_forgotten');
    });
  }
});
