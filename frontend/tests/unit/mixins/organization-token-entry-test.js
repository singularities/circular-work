import Ember from 'ember';
import OrganizationTokenEntryMixin from 'frontend/mixins/organization-token-entry';
import { module, test } from 'qunit';

module('Unit | Mixin | organization token entry');

// Replace this with your real tests.
test('it works', function(assert) {
  let OrganizationTokenEntryObject = Ember.Object.extend(OrganizationTokenEntryMixin);
  let subject = OrganizationTokenEntryObject.create();
  assert.ok(subject);
});
