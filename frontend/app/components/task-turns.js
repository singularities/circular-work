import Ember from 'ember';

export default Ember.Component.extend({
  store: Ember.inject.service(),

  excludedGroups: [],
  excludedGroupsJoin: Ember.computed('excludedGroups.[]', function() {
    return this.get('excludedGroups').mapBy('name').join(', ');
  }),

  actions: {
    addTurn () {
      let turn =
        this.get('store')
            .createRecord('turn', { position: this.get('task.turns.length') + 1 });

      this.get('task.turns').pushObject(turn);
    },
    reorderTurns (turns) {
      turns.forEach((turn, i) => {
        var newPosition = i + 1;

        if (turn.get('position') !== newPosition) {
          turn.set('position', newPosition);

          // We actually save positions in backend when the turn is saved
        }
      });
    }
  }
});
