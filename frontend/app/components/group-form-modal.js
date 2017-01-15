import Ember from 'ember';

export default Ember.Component.extend({

  openConfirmRemove: false,

  actions: {
    cancel () {
      this.get('group').rollbackAttributes();
    },

    cancelRemove () {
      this.set('open', true);
    },

    confirmRemove () {
      this.set('open', false);

      this.set('openConfirmRemove', true);
    },

    remove () {

      this.get('group').destroyRecord().then(() => {
        this.set('openConfirmRemove', false);
      }).catch(() => {
        // TODO show catched error in group Errors
      });
    },

    save () {
      let group  = this.get('group'),
          onSave = this.get('onSave');

      group.save().then(() => {

        if (onSave) {
          onSave(group);
        }

        this.set('groupErrors', null);

        this.set('open', false);
      }).catch(() => {
        // TODO show catched error in group Errors
        this.set('groupErrors', group.get('errors'));
      });

    },
  }
});
