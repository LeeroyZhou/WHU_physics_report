classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        GridLayout        matlab.ui.container.GridLayout
        LeftPanel         matlab.ui.container.Panel
        Label             matlab.ui.control.Label
        EditField         matlab.ui.control.NumericEditField
        t1EditFieldLabel  matlab.ui.control.Label
        t1EditField       matlab.ui.control.NumericEditField
        t3EditFieldLabel  matlab.ui.control.Label
        t3EditField       matlab.ui.control.NumericEditField
        Button            matlab.ui.control.Button
        RightPanel        matlab.ui.container.Panel
        UIAxes            matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    
    properties (Access = public)
        a1 % Description
        t_1
        t_3
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, a1, t_1, t_3)
            
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {480, 480};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {171, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            funcapp(app.a1,app.t_1,app.t_3,app.UIAxes);
        end

        % Value changed function: EditField
        function EditFieldValueChanged(app, event)
            value = app.EditField.Value;
            app.a1=value;
        end

        % Value changed function: t1EditField
        function t1EditFieldValueChanged(app, event)
            value = app.t1EditField.Value;
            app.t_1=value;
        end

        % Value changed function: t3EditField
        function t3EditFieldValueChanged(app, event)
            value = app.t3EditField.Value;
            app.t_3=value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {171, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create Label
            app.Label = uilabel(app.LeftPanel);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [7 346 41 22];
            app.Label.Text = '加速度';

            % Create EditField
            app.EditField = uieditfield(app.LeftPanel, 'numeric');
            app.EditField.ValueChangedFcn = createCallbackFcn(app, @EditFieldValueChanged, true);
            app.EditField.Position = [63 346 100 22];

            % Create t1EditFieldLabel
            app.t1EditFieldLabel = uilabel(app.LeftPanel);
            app.t1EditFieldLabel.HorizontalAlignment = 'right';
            app.t1EditFieldLabel.Position = [26 308 25 22];
            app.t1EditFieldLabel.Text = 't1';

            % Create t1EditField
            app.t1EditField = uieditfield(app.LeftPanel, 'numeric');
            app.t1EditField.ValueChangedFcn = createCallbackFcn(app, @t1EditFieldValueChanged, true);
            app.t1EditField.Position = [66 308 100 22];

            % Create t3EditFieldLabel
            app.t3EditFieldLabel = uilabel(app.LeftPanel);
            app.t3EditFieldLabel.HorizontalAlignment = 'right';
            app.t3EditFieldLabel.Position = [23 272 25 22];
            app.t3EditFieldLabel.Text = 't3';

            % Create t3EditField
            app.t3EditField = uieditfield(app.LeftPanel, 'numeric');
            app.t3EditField.ValueChangedFcn = createCallbackFcn(app, @t3EditFieldValueChanged, true);
            app.t3EditField.Position = [63 272 100 22];

            % Create Button
            app.Button = uibutton(app.LeftPanel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [36 194 100 24];
            app.Button.Text = '演示';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.TitleFontWeight = 'bold';
            app.UIAxes.Position = [54 126 328 266];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end