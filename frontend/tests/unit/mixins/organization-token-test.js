import Ember from 'ember';
import OrganizationTokenMixin from 'frontend/mixins/organization-token';
import { module, test } from 'qunit';

module('Unit | Mixin | organization token');

// Replace this with your real tests.
test('it works', function(assert) {
  let OrganizationTokenObject = Ember.Object.extend(OrganizationTokenMixin);
  let subject = OrganizationTokenObject.create();
  assert.ok(subject);
});
