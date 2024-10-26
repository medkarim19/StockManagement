import { createSlice } from '@reduxjs/toolkit';

const userSlice = createSlice({
  name: 'user',
  initialState: {
    isSuperUser: false,
  },
  reducers: {
    handlePermission: (state) => {
      state.isSuperUser = true;
    },
  },
});

export const { handlePermission} = userSlice.actions;
export default userSlice.reducer;