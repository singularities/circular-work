// app/adapters/application.js
import DS from 'ember-data';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';
import OrganizationToken from '../mixins/organization-token';

export default DS.JSONAPIAdapter.extend(OrganizationToken, DataAdapterMixin, {
  authorizer: 'authorizer:devise'
});
