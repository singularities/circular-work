import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel(transition) {
    if (transition.targetName === 'session.index') {
      this.replaceWith('session.login');
    }
  }
});
