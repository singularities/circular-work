import Ember from 'ember';

export default Ember.Route.extend({
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
