import Ember from 'ember';
import config from '../config/environment';

/**
 * Add this to routes that are an entry point
 * with the organization token, and must save it
 * before accesing the model
 */
export default Ember.Mixin.create({
  organizationToken: Ember.inject.service(),

  // Set the organization authentication token for future requests
  beforeModel(transition) {
    if (transition.queryParams.token) {
      this.set('organizationToken.token', transition.queryParams.token);
    }
  },

  actions: {
    // If the token has expired, the model call will return a 401 unauthorized
    // we redirect then to login
    error() {
      this.transitionTo(config['ember-simple-auth'].authenticationRoute);
    }
  }
});
