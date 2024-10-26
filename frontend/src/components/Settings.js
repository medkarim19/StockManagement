import React from 'react';
import { backupDatabase, restoreDatabase } from 'settings/settingApi';
import Header from "components/Headers/Header.js";

const BackupRestoreComponent = () => {
    const handleBackup = async () => {
        await backupDatabase();
    };

    const handleRestore = async () => {
        await restoreDatabase();
    };

    return (
        <>
            <Header />
            <div style={containerStyle}>
                <h2 style={headerStyle}>Save and Restore Your Data</h2>
                <div style={buttonContainerStyle}>
                    <button style={buttonStyle} onClick={handleBackup}>Backup Database</button>
                    <button style={buttonStyle} onClick={handleRestore}>Restore Database</button>
                </div>
            </div>
        </>
    );
};

export default BackupRestoreComponent;

const containerStyle = {
    margin: '20px auto',
    width: '80%',
    textAlign: 'center',
};

const headerStyle = {
    fontSize: '24px',
    marginBottom: '20px',
};

const buttonContainerStyle = {
    display: 'flex',
    justifyContent: 'center',
};

const buttonStyle = {
    padding: '10px 20px',
    margin: '0 10px',
    fontSize: '18px',
    backgroundColor: '#5e72e4', /* Blue */
    color: 'white',
    border: 'none',
    borderRadius: '5px',
    cursor: 'pointer',
};
