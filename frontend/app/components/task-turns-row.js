import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  showing: Ember.computed.not('editing'),

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
    edit() {
      this.set('editing', true);
    },
    save() {
      // TODO: save turn

      this.set('editing', false);
    }
  }
});
