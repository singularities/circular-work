import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params) {
    return this.get('store').find('task', params.task_id);
  },
  actions: {
    updateTask(task) {
      var route = this;
      task.save().then(function() {
        route.transitionTo('tasks.index');
      }).catch(function() { });
    }
  }
});
