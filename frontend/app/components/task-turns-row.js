import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  store: Ember.inject.service(),
  i18n: Ember.inject.service(),

  showing: Ember.computed.not('editing'),
  showRemoveTurnModal: false,
  showGroupModal: false,

  canEditTurn: Ember.computed('turn.organization.isAdmin', function() {
    return this.get('turn.organization.isAdmin');
  }),

  selectedGroups: Ember.computed('turn.groups.@each', {
    get() {
      return this.get('turn.groups');
    },
    set(key, newGroups) {
      var oldGroups = this.get('turn.groups');

      newGroups.forEach(function(newGroup) {
        if (! oldGroups.includes(newGroup)) {
          oldGroups.pushObject(newGroup);
        }
      });

      oldGroups.forEach(function(oldGroup) {
        if (! newGroups.includes(oldGroup)) {
          oldGroups.removeObject(oldGroup);
        }
      });

      return oldGroups;
    }
  }),

  init() {
    this._super(...arguments);

    if (this.get('turn.isNew')) {
      this.set('editing', true);

      if (! this.get('turn.task.excludedGroups.length')) {
        this.setNewModal();
      }
    }
  },

  setNewModalGroup () {
    let group = this.get('store')
        .createRecord('group');

    group.set('organization', this.get('turn.organization'));

    this.set('modalGroup', group);
  },

  setNewModal () {
    this.setNewModalGroup();

    this.set('modalGroupTitle', this.get('i18n').t('tasks.turns.addModal.title'));

    this.set('showGroupModal', true);
  },

  actions: {
    openSelect () {
      this.get('groupsSelectController').actions.open();
    },
    addGroup: function() {
      this.setNewModal();
    },
    editGroup: function(group) {
      this.set('modalGroup', group);

      this.set('modalGroupTitle', this.get('i18n').t('groups.modal.edit.title'));

      this.set('showGroupModal', true);
    },
    createGroup: function(group) {
      this.get('turn.groups').pushObject(group);

      this.set('modalGroup', null);
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
