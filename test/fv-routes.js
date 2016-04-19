angular
    .module( 'forbrukervalget' )
    .config( routes );

/* eslint-disable */

/*
 * ---------------------------------------------------------------------------
 * Application Routes
 * ---------------------------------------------------------------------------
 * This document defines the base routes for the application.
 */
function routes( $urlRouterProvider, $stateProvider ) {

    $urlRouterProvider.otherwise( function ( $injector, $location ) {
        var state = $injector.get( '$state' );
        state.go( '404' );
        return $location.path();
    } );

    $stateProvider

        .state( '404', {
            templateUrl: 'views/404.html',
            resolve: {
                $title: function () {
                    return '404 - Forbrukervalget';
                }
            }
        } )

        .state( 'backoffice', {
            abstract: true,
            url: '/backoffice',
            templateUrl: 'views/backoffice/base.html',
            controller: 'BackofficeController as backoffice',
            resolve: {
                $title: function () {
                    return 'Backoffice - Forbrukervalget';
                }
            }
        } )

        .state( 'articles', {
            url: '/',
            abstract: true,
            template: '<ui-view></ui-view>'
        } )

        .state( 'articles.index', {
            url: '',
            templateUrl: 'views/articles/index.html',
            controller: 'ArticlesIndexController as articlesCtrl',
            resolve: {
                $title: function () {
                    return 'Forbrukervalget - Nettavis og forbrukerportal';
                }
            }
        } )

        .state( 'articles.show', {
            url: 'artikkel/{id}/{title}',
            templateUrl: 'views/articles/show.html',
            controller: 'ArticlesShowController as articleCtrl',
            resolve: {
                article: [ 'articles', '$stateParams', function ( articles, $stateParams ) {
                    return articles.get( $stateParams.id ).then( function ( article ) {
                        return article;
                    } );
                } ],
                $title: [ 'article', function ( article ) {
                    return article.title + ' - Forbrukervalget';
                } ]
            }
        } )

        .state( 'news', {
            url: '/nyheter',
            templateUrl: 'views/articles/news.html',
            controller: 'NewsController as articlesCtrl',
            resolve: {
                $title: function () {
                    return 'Nyheter - Forbrukervalget';
                }
            }
        } )

        .state( 'domains', {
            url: '/',
            abstract: true,
            template: '<ui-view></ui-view>'
        } )

        .state( 'domains.index', {
            url: 'kalkulatorer',
            templateUrl: 'views/domains/index.html',
            controller: 'DomainsIndexController as domainCtrl',
            resolve: {
                $title: function () {
                    return 'Kalkulatorer - Forbrukervalget';
                }
            }
        } )

        .state( 'info', {
            abstract: true,
            template: '<ui-view></ui-view>'
        } )

        .state( 'info.about', {
            url: '/om-forbrukervalget',
            templateUrl: 'views/info/about.html',
            resolve: {
                $title: function () {
                    return 'Om Forbrukervalget - Forbrukervalget';
                }
            }
        } )

        .state( 'info.guide', {
            url: '/forbrukerguide',
            templateUrl: 'views/info/guide.html',
            resolve: {
                $title: function () {
                    return 'Forbrukerguide - Forbrukervalget';
                }
            }
        } )

        .state( 'errors', {
            abstract: true,
            template: '<ui-view></ui-view>'
        } );
}
