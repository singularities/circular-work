import { moduleForModel, test } from 'ember-qunit';
import Ember from 'ember';
import moment from 'moment';

moduleForModel('task', 'Unit | Model | task', {
  // Specify the other units that are required for this test.
  needs: [ 'model:turn' ]
});

test('it exists', function(assert) {
  let model = this.subject();
  // let store = this.store();
  assert.ok(!!model);
});

test('dayWithPositionOfTheMonth', function(assert) {
  let model = this.subject(),
      date = moment('2016-11-22'),
      matchDate;



  Ember.run(() => {
    model.set('recurrence', 3);
  });

  //FIXME DRY this!

  Ember.run(() => {
    model.set('recurrenceMatchPosition', 1);
    model.set('recurrenceMatchDay', 1);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-07'), 'match before start month');

  Ember.run(() => {
    model.set('recurrenceMatchPosition', 1);
    model.set('recurrenceMatchDay', 6);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-05'), 'match after start month');

  Ember.run(() => {
    model.set('recurrenceMatchPosition', 1);
    model.set('recurrenceMatchDay', 2);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-01'), 'match on start month');

  Ember.run(() => {
    model.set('recurrenceMatchPosition', -1);
    model.set('recurrenceMatchDay', 1);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-28'), 'match before end month');

  Ember.run(() => {
    model.set('recurrenceMatchPosition', -1);
    model.set('recurrenceMatchDay', 6);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-26'), 'match after end month');

  Ember.run(() => {
    model.set('recurrenceMatchPosition', -1);
    model.set('recurrenceMatchDay', 3);

    matchDate = model.dayWithPositionOfTheMonth(date);
  });

  assert.ok(matchDate.isSame('2016-11-30'), 'match on end month');
});
