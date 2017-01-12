import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    cancel () {
      this.get('group').rollbackAttributes();
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
