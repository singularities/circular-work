import Ember from 'ember';

export default Ember.Component.extend({
  showing: Ember.computed.not('editing'),
  actions: {
    edit() {
      this.set('editing', true);
    },
    save() {
      this.task.save().then(() => {
        this.set('editing', false);
      });
    }
  }
});
