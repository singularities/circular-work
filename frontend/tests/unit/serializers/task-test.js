import { moduleForModel, test } from 'ember-qunit';
import Ember from 'ember';

moduleForModel('task', 'Unit | Serializer | task', {
  needs: [ 'serializer:task', 'model:task', 'model:turn', 'model:group' ]
});

test('it serializes included turns', function(assert) {
  var record = this.subject();
  var store  = this.store();

  Ember.run(function() {
    record.set('title', 'test task');
    var turn = store.createRecord('turn', { });
    record.get('turns').pushObject(turn);
  });

  var serializedRecord = record.serialize();

  assert.deepEqual(serializedRecord, {
    "data": {
      "attributes": {
        "description": null,
        "email": null,
        "notification-email": null,
        "notification-subject": null,
        "recurrence": null,
        "recurrence-match": null,
        "title": "test task"
      },
      "type": "tasks"
    },
    "included" : {

    }
  });
});
