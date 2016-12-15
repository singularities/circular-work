import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns-row'],

  showing: Ember.computed.not('editing'),

  availableGroups: [],
  selectedGroups: Ember.computed('turn.groups.@each', {
    get() {
      return this.get('turn.groups');
    },
    set(key, value) {
      return this.get('turn').set('groups', value);
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
