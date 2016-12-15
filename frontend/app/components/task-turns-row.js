import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  showing: Ember.computed.not('editing'),

  actions: {
    edit() {
      this.set('editing', true);
    }
  }
});
