import Ember from 'ember';

export default Ember.Component.extend({
  showing: Ember.computed.not('editing'),
  showForm: Ember.computed('editing', 'task.notificationEmpty', function() {
    return (! this.get('task.notificationEmpty')) || this.get('editing');
  })
});
