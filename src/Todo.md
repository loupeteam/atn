# Is this a good Api for Modular machines?

Open for debate

## Pros:
- decouples the systems
- supports changes to subsystems
- Can consolidate info about commands and statuses

## Cons:
- performance?
- Confusing?
- Complicated?


# Can we really support substates?
- What do we do if there are multiple threads asking for an action?
- How can we simplify the problem space?
    - force only registering to a single action?


## Actually TODO:
- Handle Passing errors
- Documentation
- Build up diagnostics interface
- Performance test