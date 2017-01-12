import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['organization-new'],

  store: Ember.inject.service(),

  organization: {},
  openModal: false,

  actions: {
    showModal () {
      this.set('openModal', true);
    },
    create () {
      this.get('store').createRecord('organization', this.get('organization')).save().then(() => {
        this.set('openModal', false);
      });
    },
    cancel () {
      this.set('organization', {});

      this.set('openModal', false);
    }
  }
});
