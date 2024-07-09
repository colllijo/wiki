---
weight: 331
title: "Ngrx"
description: "Documentation for Ngrx. Reactive State Framework for Angular."
icon: "article"
date: "2024-06-25T14:00:20+02:00"
lastmod: "2024-06-25T14:00:20+02:00"
draft: false
toc: true
---

## Introduction

[Ngrx](https://ngrx.io) is a framework for Angular that allows you to create reactive
applications. NgRx is based on the concept of the [Redux](https://redux.js.org/)
JavaScript framework.

## State

The Ngrx Store consists of several features, each of which has its
own state as well as its actions, reducers and effects.

{{< rawhtml >}}
  <img src="/docs/images/programming/angular/ngrx-state-lifecycle.png" alt="Ngrx State Management Lifecycle" width="820px" />
{{< /rawhtml >}}

### State

Here the current state of the application is stored.  
The state can be read in the application but not changed, since it is immutable.
The state can only be overwritten by a reducer with a new version of the state.

### Action

Actions are the triggers for changes and either lead to the state being
renewed by a reducer or to an effect being executed. A action can be triggered
for various reasons, such as loading a page, clicking a component or executing
an effect.

### Reducer

Reducers are pure functions that change the state of the application.
They are triggered by actions and create the new state based on the current
state and any parameters of the action. As they are pure functions, no side
effects, such as loading data, may occur.

### Effects

As most applications won't work without using side effects, Ngrx offers effects
for this purpose. These are also triggered by an action and may then trigger a
side effect, such as a database query or a REST query. The data fetched may not
be written directly to the state but must be passed on to a reducer with an
action, and only then will the state be updated.

## Feature erstellen

To illustrate the functionality of Ngrx, here is a short example.  
The below example is just one way to use Ngrx, for other possibilities and
further information it is worth consulting the official [documentation](https://ngrx.io/docs).

### Installation

```shell
ng add @ngrx/store
ng add @ngrx/effects
```

### Erstellung

session.model.ts

{{< prism lang="typescript" line-numbers="true" >}}
export interface SessionState {
  username: string | null;
  active: boolean;
  loading: boolean;
  errors: string[];
}
{{< /prism >}}

session.action.ts

{{< prism lang="typescript" line-numbers="true" >}}
import { createActionGroup, emptyProps, props } from '@ngrx/store';

export const SessionAction = createActionGroup({
  source: 'Session',
  events: {
    authenticate: props<{ username: string; password: string; }>(),
    authenticateSuccess: props<{ username: string }>(),
    authenticateFailure: props<{ errors: string[] }>(),
    logout: emptyProps(),
    logoutSuccess: emptyProps(),
    logoutFailure: props<{ errors: string[] }>(),
  }
});
{{< /prism >}}

session.reducer.ts

{{< prism lang="typescript" line-numbers="true" >}}
import { createFeature, createReducer, on } from '@ngrx/store';

import { SessionAction } from './session.action';
import { SessionState } from './session.model';

const initialState: SessionState = {
  username: null,
  active: false,
  loading: false,
  errors: []
}

export const SessionFeature = createFeature({
  name: 'Session',
  reducer: createReducer(
    initialState,
    on(
      SessionAction.authenticate,
      (state): SessionState => ({
        ...state,
        loading: true
      })
    ),
    on(
      SessionAction.authenticateSuccess,
      (state, { username }): SessionState => ({
        username,
        active: true
        loading: false,
        errors: []
      })
    ),
    on(
      SessionAction.authenticateFailure,
      (state, { errors }): SessionState => ({
        ...state,
        loading: false,
        errors
      })
    ),
    on(
      SessionAction.logout,
      (state): SessionState => ({
        ...state,
        loading: true
      })
    ),
    on(
      SessionAction.logoutSuccess,
      (state): SessionState => ({
        username: null,
        active: false
        loading: false,
        errors: []
      })
    ),
    on(
      SessionAction.logoutFailure,
      (state): SessionState => ({
        ...state,
        loading: false,
        errors
      })
    ),
  )
});
{{< /prism >}}

{{% alert context="warning" %}}
When creating a reducer with `createFeature` there must not be any optional
properties in the state.  
❌ `key ?: string`  
✔️ `key: string | null`
{{% /alert %}}

session.effect.ts

{{< prism lang="typescript" line-numbers="true" >}}
import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { catchError, exhaustMap, of } from 'rxjs';

import { AuthenticationService } from '@core/service/authentication.service';
import { SessionAction } from './session.action';

@Injectable()
export class SessionEffect {
  public authenticate$ = createEffect(() =>
    this.actions$.pipe(
      ofType(SessionAction.authenticate),
      exhaustMap(() =>
        this.authenticationService.authenticate({ username: action.username, password: action.password }).pipe(
          map((response) =>
            SessionAction.authenticateSuccess({ username: response.username })
          ),
          catchError((response) =>
            of(SessionAction.authenticateFailure({ errors: response.error.errors }))
          )
        )
      )
    )
  );

  public logout$ = createEffect(() =>
    this.actions$.pipe(
      ofType(SessionAction.logout),
      exhaustMap(() =>
        this.authenticationService.logout().pipe(
          map((response) =>
            SessionAction.logoutSuccess()
          ),
          catchError((response) =>
            of(SessionAction.logoutFailure({ errors: response.error.errors }))
          )
        )
      )
    )
  );

  constructor(
    private actions$: Actions,
    private authenticationService: AuthenticationService
  ) {}
}
{{< /prism >}}

### Registrierung

app.config.ts

{{< prism lang="typescript" line-numbers="true" >}}
...
import { provideState, provideStore } from '@ngrx/store';
import { provideEffects } from '@ngrx/effects';
...
import { SessionFeature } from '@+store/session.reducer';
import { SessionEffect } from '@+store/session.effect';
...
export const appConfig: ApplicationConfig = {
  providers: [
    ...
    provideStore(),
    provideState(SessionFeature),
    provideEffects(SessionEffect)
  ],
  ...
}
{{< /prism >}}

### Nutzung

{{< prism lang="typescript" line-numbers="true" >}}
...
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
...
import { SessionAction } from '@+store/session.action';
import { SessionFeature } from '@+store/session.reducer';
...
@Component({
  selector: 'app-session',
  standalone: true,
  imports: [],
  templateUrl: './session.component.html',
  styleUrl: './session.component.scss'
})
export class SessionComponent {
  public username$: Observable<string | null>;

  constructor(private store: Store) {
    // Read value from the State
    this.username$ = this.store.select(SessionFeature.selectUsername);
  }

  public login(username: string, password: string): void {
    // Dispatch an action
    this.store.dispatch(SessionAction.authenticate({ username, password }));
  }
}
{{< /prism >}}
