import { DefaultInitialState } from '../helpers/InitialStateHelper';

/**
 * Default reducer
 *
 * @param      {Object}  state   The state
 * @param      {Object}  action  The action
 * @return     {Object}  The next state
 */
let defaultReducer = (state = DefaultInitialState(), action) => {
    switch (action.type) {
        case 'LOAD_DEFAULT_DATA': {
            return Object.assign(...state, {});
        }

        default: {
            return state;
        }
    }
};

export default defaultReducer;
