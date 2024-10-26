import axiosInstance from "axiosApi";
import Swal from 'sweetalert2';
import "../assets/css/sweetAlertStyle.css";

export const backupDatabase = async () => {
    try {
        const response = await axiosInstance.post('backup/');
        Swal.fire({
            icon: 'success',
            title: 'Backup Completed',
            text: response.data.message,
            customClass: {
                container: 'custom-swal-container'
            }
        });
    } catch (error) {
        
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'An error occurred while backing up the database.',
            customClass: {
                container: 'custom-swal-container'
            }
        });
    }
};

export const restoreDatabase = async () => {
    try {
        const response = await axiosInstance.post('restore/');
        Swal.fire({
            icon: 'success',
            title: 'Restore Completed',
            text: response.data.message,
            customClass: {
                container: 'custom-swal-container'
            }
        });
    } catch (error) {
        
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'An error occurred while restoring the database.',
            customClass: {
                container: 'custom-swal-container'
            }
        });
    }
};