import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  store: Ember.inject.service(),

  showing: Ember.computed.not('editing'),
  showRemoveTurnModal: false,
  showGroupModal: false,

  selectedGroups: Ember.computed('turn.groups.@each', {
    get() {
      return this.get('turn.groups');
    },
    set(key, newGroups) {
      var oldGroups = this.get('turn.groups'),
          excluded = this.get('excludedGroups');

      newGroups.forEach(function(newGroup) {
        if (! oldGroups.includes(newGroup)) {
          oldGroups.pushObject(newGroup);

          // TODO save newGroup?

          if (excluded.includes(newGroup)) {
            excluded.removeObject(newGroup);
          }
        }
      });

      oldGroups.forEach(function(oldGroup) {
        if (! newGroups.includes(oldGroup)) {
          oldGroups.removeObject(oldGroup);

          // TODO save turn?

          excluded.pushObject(oldGroup);
        }
      });

      return oldGroups;
    }
  }),

  init() {
    this._super(...arguments);

    if (this.get('turn.isNew')) {
      this.set('editing', true);

      this.setNewModalGroup();
      this.set('showGroupModal', true);
    }
  },

  setNewModalGroup () {
    let group = this.get('store')
        .createRecord('group');

    this.set('modalGroup', group);
  },

  actions: {
    addGroup: function() {
      this.setNewModalGroup();

      this.set('showGroupModal', true);
    },
    editGroup: function(group) {
      this.set('modalGroup', group);

      this.set('showGroupModal', true);
    },
    createGroup: function() {
      let group = this.get('modalGroup');

      group.save().then(() => {
        this.get('turn.groups').pushObject(group);

        this.set('newGroupParams', []);

        this.set('groupErrors', null);

        this.set('modalGroup', null);

        this.set('showGroupModal', false);
      }).catch(() => {
        // TODO show catched error in group Errors
        this.set('groupErrors', group.get('errors'));
      });

    },
    cancelGroupModal () {
      let group = this.get('modalGroup');

      group.rollbackAttributes();
    },
    cancel() {
      var turn = this.get('turn');

      if (turn.get('isNew')) {
        turn.deleteRecord();
      } else {
        // TODO reset groups
      }

      // TODO reset turns that have been altered by position change

      this.set('editing', false);

    },
    removeTurnModal () {
      this.set('showRemoveTurnModal', true);
    },
    remove() {
      this.get('turn').destroyRecord();
    },
    edit() {
      this.set('editing', true);
    },
    save() {
      this.get('turn').save().then(() => {
        this.set('editing', false);

        // Reload turns that have altered their position,
        // or mark them as saved, or save them
      });

    }
  }
});
