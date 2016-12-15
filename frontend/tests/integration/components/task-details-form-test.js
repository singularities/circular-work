import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

moduleForComponent('task-details-form', 'Integration | Component | task-details-form', {
  integration: true,
  beforeEach: function() {
    let store = this.container.lookup('service:store');
    let task  = Ember.run(function() {
      return store.createRecord('task', {});
    });
    this.set('task', task);
    this.set('recurrenceOptions', []);
    this.set('recurrenceMatchPositions', []);
    this.set('recurrenceMatchDays', []);
    this.set('recurrenceMatchPositionId', 2);
    this.set('recurrenceMatchDayId', 12);
    this.set('taskErrors', []);
    this.set('createTask', "");

    this.render(hbs`{{task-details-form
      task=task
      recurrenceOptions=recurrenceOptions
      recurrenceMatchPositions=recurrenceMatchPositions
      recurrenceMatchDays=recurrenceMatchDays
      taskErrors=taskErrors
      createTask="createTask"
    }}`);

  }
});

test('should show and hide Position and Week day inputs', function(assert) {
  this.set('task.recurrence', 0);

  assert.equal(this.$().text().indexOf("Position"), -1);
  assert.equal(this.$().text().indexOf("Day of the Week"), -1);

  this.set('task.recurrence', 2);

  assert.notEqual(this.$().text().indexOf("Position"), -1);
  assert.notEqual(this.$().text().indexOf("Day of the Week"), -1);
});
