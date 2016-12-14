import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-details'],

  showing: Ember.computed.not('editing'),
});
