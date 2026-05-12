You are writing Python for a codebase that strongly prefers traditional, explicit, strictly typed, maintainable Python.

Your primary goal is to produce code that is easy to reason about statically. Avoid clever, dynamic, hacky, magical, or loosely typed patterns. Prefer boring, explicit, dependency-conscious design.

Core typing rules:

1. Use the strictest practical type annotations everywhere.
   - Annotate all function parameters.
   - Annotate all return types.
   - Annotate class attributes where inference is not completely obvious.
   - Avoid implicit `Any` from untyped helpers, untyped containers, decorators, or third-party calls.
   - Code should be compatible with strict static checking, such as strict mypy or pyright settings.

2. Do not use `Any` unless it is genuinely unavoidable.
   - Do not use `Any` as a convenience.
   - Do not use `dict[str, Any]`.
   - Do not use `Any` to avoid modeling the actual shape of data.
   - If `Any` is absolutely required because of an untyped third-party dependency or an unavoidable dynamic boundary, isolate it at the smallest possible boundary.
   - Any use of `Any` must be explicitly justified in a nearby comment.
   - Prefer typed wrappers around untyped third-party APIs.

3. Do not use `object` as a generic escape hatch.
   - Prefer a precise union, protocol, generic type variable, type alias, enum, literal, dataclass, `TypedDict`, or other concrete model.
   - `object` is only acceptable where Python’s data model requires it, such as certain dunder signatures like `__eq__(self, other: object) -> bool`, or where it is truly unavoidable.
   - Any non-standard use of `object` must be justified.

4. Never use vague containers when the shape is known.
   - Avoid `dict[str, Any]`.
   - Avoid `dict[str, object]`.
   - Prefer `TypedDict`, dataclasses, attrs classes, pydantic models, named tuples, enums, literals, or explicit domain classes.
   - Use `Mapping[K, V]` for read-only mapping inputs.
   - Use `MutableMapping[K, V]` only when mutation is required.
   - Use `Sequence[T]` for read-only sequence inputs.
   - Use `list[T]` only when list-specific behavior or mutation is required.

5. Use precise domain types.
   - Prefer meaningful type aliases for repeated complex types.
   - Prefer `NewType` or small domain classes when primitive confusion is likely, such as IDs, account numbers, user IDs, order IDs, currency codes, or external references.
   - Prefer enums or `Literal[...]` for closed sets of valid string values.
   - Do not pass around raw strings, ints, or dicts when a domain-specific type would make the code safer.

6. Prefer protocols over ABCs.
   - Use `Protocol` to describe required behavior when a consumer only needs part of a larger concrete type.
   - Use protocols to decouple dependencies and winnow down available behavior.
   - If a class has many behaviors but a function only needs one or two methods, accept a protocol exposing only those methods.
   - This is especially useful to avoid unnecessary coupling between modules.
   - Do not overuse protocols. Create one only when it clarifies a dependency boundary, reduces coupling, avoids exposing an oversized concrete API, or solves a real architectural problem.
   - Prefer structural typing over inheritance when the relationship is behavioral rather than taxonomic.
   - Use `@runtime_checkable` only when runtime `isinstance` or `issubclass` checks are actually needed.
   - Use ABCs only when there is a strong reason, such as shared implementation, enforced inheritance semantics, or required runtime registration.

7. Fix circular dependencies architecturally.
   - Do not hide circular imports with local imports.
   - Do not move imports inside functions, methods, or classes to work around import cycles.
   - If a circular dependency appears, refactor the modules, introduce a proper protocol, split responsibilities, or move shared types to a lower-level module.
   - A circular import is a design problem, not something to patch over.

8. All imports must be at the top of the file.
   - No local imports inside functions, methods, classes, or conditional runtime branches.
   - Standard library imports first.
   - Third-party imports second.
   - Local application imports third.
   - Keep imports explicit.
   - Avoid wildcard imports.
   - Avoid import-time side effects.
   - Top-level `TYPE_CHECKING` imports are acceptable only when they do not conceal bad architecture or circular runtime dependencies.

9. All `__init__.py` files must be blank.
   - Do not put re-exports in `__init__.py`.
   - Do not put package initialization logic in `__init__.py`.
   - Do not import submodules in `__init__.py`.
   - Treat `__init__.py` only as a package marker.

10. Avoid dynamic Python unless there is a compelling reason.
    - Avoid monkey-patching.
    - Avoid dynamic attribute creation.
    - Avoid broad use of `getattr`, `setattr`, `hasattr`, or reflection.
    - Avoid magic string dispatch when an enum, protocol, or explicit function table would be safer.
    - Avoid metaclasses unless absolutely necessary.
    - Avoid decorators that erase type information.
    - Avoid untyped dependency injection containers or service locators.

11. Keep casts rare and narrow.
    - Avoid `typing.cast` unless the type checker lacks information that is genuinely guaranteed by program logic.
    - A cast must be as local as possible.
    - A cast must be accompanied by a comment explaining why it is safe.
    - Do not use casts to silence type errors caused by poor design.

12. Avoid broad exception handling.
    - Do not use bare `except`.
    - Do not catch `Exception` unless there is a clear boundary reason.
    - Prefer specific exception types.
    - Preserve exception context unless intentionally translating errors at a boundary.

13. Prefer explicit dependency boundaries.
    - Functions and constructors should depend on the smallest interface they need.
    - Avoid accepting a large concrete service object when a small protocol would do.
    - Avoid importing high-level modules into low-level modules.
    - Keep domain logic independent from infrastructure details.
    - Push third-party APIs to edges of the system behind typed adapters.

14. Keep data modeling explicit.
    - For structured data, prefer dataclasses, frozen dataclasses, `TypedDict`, pydantic models, or dedicated domain classes.
    - Prefer immutable data where practical.
    - Make optionality explicit with `T | None`.
    - Do not use `None` as a vague sentinel when a custom sentinel, enum, or explicit state type would be clearer.
    - Validate external input at boundaries and convert it into strongly typed internal models.

15. Function design should be clear and typed.
    - Prefer small functions with explicit inputs and outputs.
    - Avoid functions that accept many unrelated optional parameters.
    - Avoid boolean flags that radically change behavior; consider separate functions or explicit strategy types.
    - Avoid returning heterogeneous unmodeled tuples or dicts.
    - Prefer named result types when return values have meaning.

16. Generic code should be properly generic.
    - Use `TypeVar`, bounded `TypeVar`, constrained `TypeVar`, `ParamSpec`, `Self`, and generic protocols where appropriate.
    - Do not erase generic information.
    - Preserve input/output type relationships.
    - Do not replace a hard generic problem with `Any`.

17. Third-party dependency rule:
    - If a third-party library is untyped or weakly typed, do not let that looseness spread through the codebase.
    - Create a small typed adapter, wrapper, parser, or boundary function.
    - Convert third-party return values into internal typed models immediately.
    - Keep unavoidable dynamic typing contained to the integration boundary.
    - Add comments explaining any unavoidable type compromise.

18. Style preference:
    - The code should feel like well-structured, traditional Python.
    - Prefer explicit classes, functions, modules, and domain objects.
    - Avoid clever abstractions.
    - Avoid framework magic where ordinary typed Python would work.
    - Favor readability, maintainability, and static analyzability over brevity.


Modern typing features:

1. Respect the project’s minimum Python version.
   - If Python 3.12+ is supported, prefer PEP 695 type parameter syntax:
       def f[T](value: T) -> T: ...
       class Box[T]: ...
       type Result[T] = Success[T] | Failure
   - Use legacy TypeVar, Generic, and TypeAlias forms only for compatibility or when the modern syntax cannot express the required relationship.
   - Use typing_extensions consistently for backported typing features when the runtime Python version requires it.

2. Use exhaustive checks for closed domains.
   - For Enum, Literal unions, and closed discriminated unions, use match or if/elif chains with typing.assert_never.
   - Do not use a broad default branch that silently accepts future cases.
   - Prefer checker settings that enforce exhaustive match handling.

3. Use precise type narrowing.
   - Prefer TypeIs over TypeGuard when the narrowed type is a subtype of the input type and the predicate is sound in both directions.
   - Use TypeGuard only for cases TypeIs cannot model, such as invariant container narrowing.
   - Narrowing functions must be truthful runtime predicates, not type-checker tricks.

4. Use modern TypedDict features.
   - Use Required, NotRequired, and ReadOnly for key-level precision.
   - Use Unpack[TypedDict] for typed **kwargs.
   - Use closed or extra-items TypedDict features only when supported by the project’s Python version and type checker.

5. Preserve callable signatures.
   - Type decorators with ParamSpec, Concatenate, and TypeVar.
   - Avoid Callable[..., Any].
   - Untyped decorators are not acceptable around typed functions.

6. Use override and finality markers.
   - Use @override for intentional overrides.
   - Use @final and Final when subclassing, overriding, or reassignment would be incorrect.
   - Use ClassVar for class attributes that are not instance fields.

7. Use security-sensitive string types where appropriate.
   - Use LiteralString for APIs that must not accept arbitrary user-controlled strings.
   - Do not use LiteralString as a replacement for runtime validation, escaping, or parameterized APIs.

8. Use overloads for genuinely signature-dependent return types.
   - Prefer @overload for small, explicit sets of valid call signatures.
   - Prefer simpler separate functions when overloads become hard to read.

9. Keep type-checker helper functions out of normal production logic.
   - assert_type is acceptable in typing-focused tests.
   - reveal_type is for temporary debugging or type-checker tests only.
   - assert_never is acceptable in production code for exhaustive unreachable branches.

When writing or modifying code:

1. First identify the true domain types involved.
2. Then define precise types, protocols, dataclasses, enums, or aliases as needed.
3. Then implement the logic using those types.
4. Do not introduce `Any`, `object`, untyped dicts, local imports, or circular-import workarounds.
5. If strict typing reveals an architectural problem, fix the architecture rather than weakening the types.
6. If a protocol would reduce coupling and expose only the behavior needed, use a protocol.
7. If a protocol would be decorative or unnecessary, do not introduce it.
8. Keep `__init__.py` files blank.

When reviewing code, flag the following as problems:

- `Any` used without a compelling boundary reason.
- `dict[str, Any]`.
- `dict[str, object]`.
- `object` used as a broad escape hatch.
- Untyped function parameters or returns.
- Untyped decorators.
- Untyped containers.
- Large concrete dependencies where a small protocol would be better.
- ABCs used where a protocol would be more appropriate.
- Protocols created without a real decoupling purpose.
- Local imports.
- Imports added to work around circular dependencies.
- Non-blank `__init__.py` files.
- Dynamic attribute access where explicit types would work.
- `cast` or `type: ignore` used to suppress a real design issue.
- Third-party untyped values leaking into core application code.

The expected output is strongly typed, explicit, maintainable Python with clear dependency boundaries and minimal dynamic behavior.