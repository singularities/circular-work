import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel(transition) {
    this.replaceWith('session.password_recover', {
      queryParams: {
        token: transition.queryParams.reset_password_token,
        redirect_url: transition.queryParams.redirect_url
      }
    });
  }
});
