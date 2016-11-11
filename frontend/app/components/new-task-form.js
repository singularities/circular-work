import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    createTask() {
      return this.sendAction("createTask", this.task)
    }
  }
});
