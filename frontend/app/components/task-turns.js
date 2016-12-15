import Ember from 'ember';

export default Ember.Component.extend({
  store: Ember.inject.service(),
  actions: {
    addTurn () {
      let turn =
        this.get('store')
            .createRecord('turn', { position: this.get('task.turns.length') + 1 });

      this.get('task.turns').pushObject(turn);
    },
    reorderTurns (turns, dragged) {
      turns.forEach((turn, i) => {
        var newPosition = i + 1;

        if (turn.get('position') !== newPosition) {
          turn.set('position', newPosition);

          // We only update the turn that was dragged.
          // The backend takes care of calculating new positions
          if (turn === dragged) {
            turn.save();
          }
        }
      });
    }
  }
});
