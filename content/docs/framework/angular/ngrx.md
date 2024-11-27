---
weight: 5110
title: "Ngrx"
description: "Dokumentation zu Ngrx. Reactive State Framework für Angular."
icon: "article"
date: "2024-06-25T14:00:23+02:00"
lastmod: "2024-06-25T14:00:23+02:00"
draft: false
toc: true
---

## Einführung

[Ngrx](https://ngrx.io) ist ein Framework für Angular, welches ermöglicht reaktive Applikationen zu erstellen.
Ngrx basiert auf dem Konzept des [Redux](https://redux.js.org/) Javascript Frameworks.

## State

Der Ngrx Store besteht aus mehreren Featuren, welche jeweils ihren State sowie ihre Actions, Reducer und Effects haben.

{{< figure
  src="/docs/images/programming/angular/ngrx-state-lifecycle.png"
  caption="Lebenszyklus des \"States\" in Ngrx"
  width="840px"
  alt="Ngrx State Management Lebenszyklus"
>}}

### State

Im State eines Features wird der momentane Zustand der Applikation gespeichert.  
Der State kann in der Applikation ausgelesen, aber nicht verändert werden, da er
unveränderlich ist. Der State kann nur durch einen Reducer mit einer neuen Version
des States überschrieben werden.

### Action

Aktionen sind die Auslöser für Veränderungen und führen entweder dazu, dass der State
durch einen Reducer erneuert wird oder dass ein Effekt ausgeführt wird. Eine Aktion
kann aus verschiedenen Gründen ausgelöst werden, dazu gehören das Laden einer Seite,
das Klicken einer Komponente oder das Ausführen eines Effekts.

### Reducer

Reducer sind pure Funktionen, welche den Zustand der Applikation verändern.
Sie werden durch Aktionen ausgelöst und erstellen anhand des aktuellen Zustands
und allfälligen Parametern der Aktion den neuen Zustand. Da sie jedoch pure
Funktionen sind, dürfen keine Nebeneffekte, wie zum Beispiel das Laden von Daten
stattfinden.

### Effects

Die meisten Applikationen kommen jedoch nicht ohne die Benutzung von Nebeneffekten
aus. Für dieses Bedürfnis bietet Ngrx Effekte. Diese werden ebenfalls durch eine
Aktion ausgelöst und dürfen dann einen Nebeneffekt auslösen, dass heisst zum Beispiel
eine Datenbankabfrage oder eine REST-Abfrage. Diese Daten dürfen dann jedoch nicht
direkt in den Zustand geschrieben werden, sondern mit einer Aktion an einen Reducer
weitergeleitet und erst dieser erneuert dann den Zustand.

## Feature erstellen

Um die Funktionsweise von Ngrx zu verdeutlichen hier noch ein kurzes Beispiel.  
Das unten stehende Beispiel ist nur eine Möglichkeit, Ngrx zu verwenden, für andere Möglichkeiten und weitere Informationen
lohnt es sich, die offizielle [Dokumentation](https://ngrx.io/docs) zu Hilfe zu ziehen.

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
Wenn der Reducer mit `createFeature` erstellt wird darf es im State keine
optionalen Eigenschaften geben.  
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

## Ressourcen

[Ngrx Dokumentation](https://ngrx.io/docs)  
