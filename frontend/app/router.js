import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL,
  metrics: Ember.inject.service(),

  didTransition() {
    this._super(...arguments);

    this._trackPage();
  },

  _trackPage() {
    Ember.run.scheduleOnce('afterRender', this, () => {
      const page = this.get('url');
      const title = this.getWithDefault('currentRouteName', 'unknown');

      Ember.get(this, 'metrics').trackPage({ page, title });
    });
  }
});

Router.map(function() {
  this.route('home');

  this.route('session', function() {
    this.route('login');
    this.route('register');
    this.route('password_forgotten');
    this.route('password_recover');
  });

  this.route('tasks', function() {
    this.route('index');
    this.route('new');
    this.route('show', { path: ":task_id" });
    this.route('edit', { path: ":task_id/edit" });
  });

  this.route('organizations', function() {
    this.route('new');
    this.route('show', { path: ":organization_id" });
  });

  // Define devise_token_auth recover password route
  this.route('devise_token_auth_password_recover', { path: '/users/password/edit' });
});

export default Router;
