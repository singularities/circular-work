import Ember from 'ember';
import config from './config/environment';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const Router = Ember.Router.extend().extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('login');
  this.route('tasks', function() {
    this.route('index');
    this.route('new');
    this.route('show', { path: ":task_id" });
  });
});

export default Router;
