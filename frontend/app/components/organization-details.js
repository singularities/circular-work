import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['organization-details'],

  showing: Ember.computed.not('editing'),

  actions: {
    showEdit () {
      this.set('editing', true);
    },
    cancelEdit () {

      // Should use http://emberjs.com/api/data/classes/DS.Model.html#method_resetAttribute
      // but it is not enabled by default

      this.organization.rollbackAttributes();

      this.set('editing', false);
    },
    saveEdit() {
      this.organization.save().then(() => {
        this.set('editing', false);
      });
    }
  }
});
