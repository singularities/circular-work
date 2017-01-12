import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-turns'],

  store: Ember.inject.service(),

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
