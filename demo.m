classdef demo < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure            matlab.ui.Figure
        GridLayout          matlab.ui.container.GridLayout
        LeftPanel           matlab.ui.container.Panel
        t1EditFieldLabel    matlab.ui.control.Label
        t1EditField         matlab.ui.control.NumericEditField
        t3EditFieldLabel    matlab.ui.control.Label
        t3EditField         matlab.ui.control.NumericEditField
        Button              matlab.ui.control.Button
        Label_2             matlab.ui.control.Label
        Slider              matlab.ui.control.Slider
        RightPanel          matlab.ui.container.Panel
        UIAxes              matlab.ui.control.UIAxes
        TimeTextAreaLabel   matlab.ui.control.Label
        Time                matlab.ui.control.TextArea
        AngleTextAreaLabel  matlab.ui.control.Label
        Angle               matlab.ui.control.TextArea
        MmaxTextAreaLabel   matlab.ui.control.Label
        Mmax                matlab.ui.control.TextArea
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    
    properties (Access = public)
        a1 % Description
        t_1
        t_3
        h
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, a1, t_1, t_3)
            app.h = animatedline(app.UIAxes);
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

        % Callback function: Angle, Button, Mmax
        function ButtonPushed(app, event)
            %clf(app.UIAxes);
            app.h.LineWidth=0.7;
            app.h.Color='r';
            [app.Time.Value,app.Angle.Value,app.Mmax.Value]=funcapp(app.a1,app.t_1,app.t_3,app.h);
        end

        % Callback function
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

        % Value changed function: Slider
        function SliderValueChanged(app, event)
            value = app.Slider.Value;
            app.a1=value;
        end

        % Callback function
        function UITableDisplayDataChanged(app, event)
      
            
        end

        % Callback function
        function UITableCellEdit(app, event)
            
        end

        % Value changed function: Time
        function TimeValueChanged(app, event)

            
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
            app.LeftPanel.TitlePosition = 'centertop';
            app.LeftPanel.Title = '可调参数';
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create t1EditFieldLabel
            app.t1EditFieldLabel = uilabel(app.LeftPanel);
            app.t1EditFieldLabel.HorizontalAlignment = 'right';
            app.t1EditFieldLabel.Position = [17 263 25 22];
            app.t1EditFieldLabel.Text = 't1';

            % Create t1EditField
            app.t1EditField = uieditfield(app.LeftPanel, 'numeric');
            app.t1EditField.ValueChangedFcn = createCallbackFcn(app, @t1EditFieldValueChanged, true);
            app.t1EditField.Position = [57 263 100 22];

            % Create t3EditFieldLabel
            app.t3EditFieldLabel = uilabel(app.LeftPanel);
            app.t3EditFieldLabel.HorizontalAlignment = 'right';
            app.t3EditFieldLabel.Position = [16 226 25 22];
            app.t3EditFieldLabel.Text = 't3';

            % Create t3EditField
            app.t3EditField = uieditfield(app.LeftPanel, 'numeric');
            app.t3EditField.ValueChangedFcn = createCallbackFcn(app, @t3EditFieldValueChanged, true);
            app.t3EditField.Position = [56 226 100 22];

            % Create Button
            app.Button = uibutton(app.LeftPanel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [36 166 100 24];
            app.Button.Text = '演示';

            % Create Label_2
            app.Label_2 = uilabel(app.LeftPanel);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [8 311 41 22];
            app.Label_2.Text = '加速度';

            % Create Slider
            app.Slider = uislider(app.LeftPanel);
            app.Slider.Limits = [0 1];
            app.Slider.ValueChangedFcn = createCallbackFcn(app, @SliderValueChanged, true);
            app.Slider.Position = [59 332 99 3];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.TitlePosition = 'centertop';
            app.RightPanel.Title = '龙门吊演示';
            app.RightPanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.RightPanel);
            title(app.UIAxes, 'x-y图像')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.XLim = [0 100];
            app.UIAxes.YLim = [-15 -14.75];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.TitleFontWeight = 'bold';
            app.UIAxes.Position = [10 197 438 250];

            % Create TimeTextAreaLabel
            app.TimeTextAreaLabel = uilabel(app.RightPanel);
            app.TimeTextAreaLabel.HorizontalAlignment = 'right';
            app.TimeTextAreaLabel.Position = [42 155 32 22];
            app.TimeTextAreaLabel.Text = 'Time';

            % Create Time
            app.Time = uitextarea(app.RightPanel);
            app.Time.ValueChangedFcn = createCallbackFcn(app, @TimeValueChanged, true);
            app.Time.Tag = 'Time';
            app.Time.Position = [89 155 150 24];

            % Create AngleTextAreaLabel
            app.AngleTextAreaLabel = uilabel(app.RightPanel);
            app.AngleTextAreaLabel.HorizontalAlignment = 'right';
            app.AngleTextAreaLabel.Position = [38 99 36 22];
            app.AngleTextAreaLabel.Text = 'Angle';

            % Create Angle
            app.Angle = uitextarea(app.RightPanel);
            app.Angle.ValueChangedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Angle.Tag = 'Angle';
            app.Angle.Position = [89 99 150 24];

            % Create MmaxTextAreaLabel
            app.MmaxTextAreaLabel = uilabel(app.RightPanel);
            app.MmaxTextAreaLabel.HorizontalAlignment = 'right';
            app.MmaxTextAreaLabel.Position = [36 36 38 22];
            app.MmaxTextAreaLabel.Text = 'Mmax';

            % Create Mmax
            app.Mmax = uitextarea(app.RightPanel);
            app.Mmax.ValueChangedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Mmax.Tag = 'Mmax';
            app.Mmax.Position = [89 36 150 24];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = demo(varargin)

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