import { moduleForModel, test } from 'ember-qunit';

moduleForModel('turn', 'Unit | Model | turn', {
  // Specify the other units that are required for this test.
  needs: [ 'model:task', 'model:group' ]
});

test('it exists', function(assert) {
  let model = this.subject();
  // let store = this.store();
  assert.ok(!!model);
});
