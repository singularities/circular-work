import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('task-notifications', 'Integration | Component | task notifications', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{task-notifications}}`);

  // Not sure if we have to waste time in integration tests
  // I prefer unit and acceptance
  assert.equal(this.$().text().indexOf("ToDo"), -1);
});
