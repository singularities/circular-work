import Ember from 'ember';

export default Ember.Component.extend({
  showing: Ember.computed.not('editing'),
});
