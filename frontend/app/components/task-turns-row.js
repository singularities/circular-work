import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  store: Ember.inject.service(),

  showing: Ember.computed.not('editing'),
  showNewGroupModal: false,
  newGroupParams: Ember.computed('newGroupName', 'newGroupEmails', {
    get() {
      return {
        name:   this.get('newGroupName'),
        emails: this.get('newGroupEmails')
      };
    },
    set(key, args) {
      this.set('newGroupName', args[0]);
      this.set('newGroupEmails', args[1]);

      return this.get('newGroupParams');
    }
  }),

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

  actions: {
    addGroup: function() {
      this.set('showNewGroupModal', true);
    },
    createGroup: function() {
      let group = this.get('store')
        .createRecord('group', this.get('newGroupParams'));

      this.get('turn.groups').pushObject(group);

      this.set('newGroupParams', []);

      this.set('showNewGroupModal', false);
    },
    cancel() {
      // TODO reset turns
      this.set('editing', false);

    },
    edit() {
      this.set('editing', true);
    },
    save() {
      // TODO: save turn
      this.get('turn').save().then(() => {
        this.set('editing', false);
      });

    }
  }


});