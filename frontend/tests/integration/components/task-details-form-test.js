import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import Ember from 'ember';

moduleForComponent('task-details-form', 'Integration | Component | task-details-form', {
  integration: true,
  beforeEach: function() {
    let store = this.container.lookup('service:store');
    let Task = {
      recurrenceOptions: [],
      recurrenceMatchPositionOptions: [],
      recurrenceMatchDayOptions: []
    };
    let task  = Ember.run(function() {
      return store.createRecord('task', {});
    });
    this.set('task', task);
    this.set('Task', Task);
    this.set('taskErrors', []);
    this.set('createTask', "");

    this.render(hbs`{{task-details-form
      task=task
      Task=Task
      taskErrors=taskErrors
      createTask="createTask"
    }}`);

  }
});

test('should show and hide Position and Week day inputs', function(assert) {
  // Quick hack to search for position and week inputs
  var inputSelector = '.col-sm-3';

  this.set('task.recurrence', 1);

  assert.notOk(this.$(inputSelector).length);

  this.set('task.recurrence', 2);

  assert.ok(this.$(inputSelector).length);
});
