Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Notepad+-"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.StartPosition = "CenterScreen"

# Create a TableLayoutPanel to manage layout
$tableLayoutPanel = New-Object System.Windows.Forms.TableLayoutPanel
$tableLayoutPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$tableLayoutPanel.RowCount = 2
$tableLayoutPanel.ColumnCount = 1
$tableLayoutPanel.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::AutoSize)))
$tableLayoutPanel.RowStyles.Add((New-Object System.Windows.Forms.RowStyle([System.Windows.Forms.SizeType]::Percent, 100)))

# Create a RichTextBox for text editing with default font settings
$textBox = New-Object System.Windows.Forms.RichTextBox
$textBox.Multiline = $true
$textBox.Dock = [System.Windows.Forms.DockStyle]::Fill
$textBox.Font = New-Object System.Drawing.Font("Calibri", 12)

# Create a toolbar
$toolStrip = New-Object System.Windows.Forms.ToolStrip
$toolStrip.Dock = [System.Windows.Forms.DockStyle]::Top

# Load icons
$iconSave = [System.Drawing.Icon]::ExtractAssociatedIcon("E:\Notepad+-\save.ico")
$iconOpen = [System.Drawing.Icon]::ExtractAssociatedIcon("E:\Notepad+-\open.ico")

# Create toolbar buttons with icons
$btnSave = New-Object System.Windows.Forms.ToolStripButton
$btnSave.Image = $iconSave.ToBitmap()
$btnSave.ToolTipText = "Save"
$btnSave.add_Click({
    $saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveFileDialog.Filter = "Text Files (*.txt)|*.txt"
    if ($saveFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $textBox.SaveFile($saveFileDialog.FileName, [System.Windows.Forms.RichTextBoxStreamType]::PlainText)
    }
})

$btnOpen = New-Object System.Windows.Forms.ToolStripButton
$btnOpen.Image = $iconOpen.ToBitmap()
$btnOpen.ToolTipText = "Open"
$btnOpen.add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "Text Files (*.txt)|*.txt"
    if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $textBox.LoadFile($openFileDialog.FileName, [System.Windows.Forms.RichTextBoxStreamType]::PlainText)
    }
})

# Add buttons to the toolbar
$toolStrip.Items.Add($btnSave)
$toolStrip.Items.Add($btnOpen)

# Add controls to the TableLayoutPanel
$tableLayoutPanel.Controls.Add($toolStrip, 0, 0)
$tableLayoutPanel.Controls.Add($textBox, 0, 1)

# Add TableLayoutPanel to the form
$form.Controls.Add($tableLayoutPanel)

# Set form icon
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("E:\Notepad+-\root.ico")

# Run the form
$form.ShowDialog()
