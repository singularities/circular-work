import Ember from 'ember';

export default Ember.Route.extend({
  organizationToken: Ember.inject.service(),

  // Set the organization authentication token for future requests
  beforeModel(transition) {
    if (transition.queryParams.token) {
      this.set('organizationToken.token', transition.queryParams.token);
    }
  },
  model(params) {
    return this.get('store').findRecord('organization', params.organization_id);
  }
});
