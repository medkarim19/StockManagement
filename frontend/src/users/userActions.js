import { handlePermission as userHandlePermission } from './userReducer';

export const handlePermission = () => {
  return (dispatch) => {
    dispatch(userHandlePermission());
  };
};