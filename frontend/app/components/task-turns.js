import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
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
