import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model() {
    return this.get('store').createRecord('task');
  },
  actions: {
    createTask(task) {
      var route = this;
      task.save().then(function() {
        route.transitionTo('tasks.index');
      }).catch(function() { });
    }
  }
});
